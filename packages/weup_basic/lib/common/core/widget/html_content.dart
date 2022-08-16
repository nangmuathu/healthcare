import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weup_basic/global.dart';

import '../../resource/image_resource.dart';

class HtmlComp extends StatelessWidget {
  final String content;

  const HtmlComp({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = content + styleCustom;
    return Html(
      data: data,
      onLinkTap: (url, _, __, ___) async {
        if (await canLaunch(url!)) {
          await launch(url);
        } else {
          throw "Could not launch $url";
        }
      },
      customRender: {
        "table": (RenderContext ctx, Widget child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: (ctx.tree as TableLayoutElement).toWidget(ctx),
          );
        },
        "li": (RenderContext ctx, Widget child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.black.withOpacity(0.7))),
              const SizedBox(width: 5),
              Expanded(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - 45,
                      child: Text(ctx.tree.element!.text,
                          style: const TextStyle(height: 1.5, fontSize: 14)))),
            ],
          );
        },
        "img": (RenderContext ctx, Widget child) {
          return CachedNetworkImage(
            imageUrl: ctx.tree.element?.attributes['src'] ?? '',
            placeholder: (context, url) {
              return Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: appStyle.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Image.asset(ImageResource.imgPlaceholder);
            },
          );
        }
      },
      style: {
        ".image": Style(
          margin: const EdgeInsets.only(top: 5, bottom: 20),
        ),
        "ul,ol,dl": Style(
          padding: const EdgeInsets.only(left: 15),
        )
      },
    );
  }

  String get styleCustom => """<style>
    p{
      font-size: 14px;
      line-height: 1.3em;
      margin: 0 0 15px 0;
    }
    li{
      font-size: 14px;
      margin: 10px 0;
    }
    code {
        display: inline-block;
        background-color: hsla(0, 0%, 78%, 0.3);
        padding: 5px;
        border-radius: 2px;
        margin-bottom: 15px;
        color: #e83e8c;
        word-break: break-word;
        font-size: 12px;
    }
    .text-tiny {
        font-size: .7em;
    }
    .text-small {
        font-size: .85em;
    }
    .text-big {
        font-size: 1.4em;
    }
    .text-huge {
        font-size: 1.8em;
    }
    blockquote {
        overflow: hidden;
        padding: 6px 20px;
        margin: 0 0 15px 0;
        font-style: italic;
        border-left: solid 5px hsl(0, 0%, 80%);
    }
    [dir='rtl'] blockquote {
        border-left: 0;
        border-right: solid 5px hsl(0, 0%, 80%);
    }
    .marker-yellow {
        background-color: hsl(60, 97%, 73%);
    }
    .marker-green {
        background-color: hsl(120, 93%, 68%);
    }
    .marker-pink {
        background-color: hsl(345, 96%, 73%);
    }
    .marker-blue {
        background-color: hsl(201, 97%, 72%);
    }
    .pen-red {
        color: hsl(0, 85%, 49%);
        background-color: transparent;
    }
    .pen-green {
        color: hsl(112, 100%, 27%);
        background-color: transparent;
    }
    .image {
        display: table;
        clear: both;
        text-align: center;
        min-width: 50px;
    }
    .image img {
        display: block;
        margin: 0 auto;
        max-width: 100%;
        min-width: 100%;
    }
    .image-inline {
        display: inline-flex;
        max-width: 100%;
        align-items: flex-start;
    }
    .image-inline picture {
        display: flex;
    }
    .image-inline picture,
    .image-inline img {
        flex-grow: 1;
        flex-shrink: 1;
        max-width: 100%;
    }
    .image > figcaption {
        display: block;
        caption-side: bottom;
        word-break: break-word;
        color: hsl(0, 0%, 20%);
        background-color: hsla(0, 0%, 0%, 5%);
        padding: 7px 10px;
        font-size: 12px;
        outline-offset: -1px;
    }
    .image-style-block-align-left,
    .image-style-block-align-right {
        max-width: calc(100% - 1.5em);
    }
    .image-style-align-left,
    .image-style-align-right {
        clear: none;
    }
    .image-style-side {
        float: right;
        margin-left: 1.5em;
        max-width: 50%;
    }
    .image-style-align-left {
        float: left;
        margin-right: 1.5em;
    }
    .image-style-align-center {
        margin-left: auto;
        margin-right: auto;
    }
    .image-style-align-right {
        float: right;
        margin-left: 1.5em;
    }
    .image-style-block-align-right {
        margin-right: 0;
        margin-left: auto;
    }
    .image-style-block-align-left {
        margin-left: 0;
        margin-right: auto;
    }
    p + .image-style-align-left,
    p + .image-style-align-right,
    p + .image-style-side {
        margin-top: 0;
    }
    .image-inline.image-style-align-left,
    .image-inline.image-style-align-right {
        margin-top: calc(1.5em / 2);
        margin-bottom: calc(1.5em / 2);
    }
    .image-inline.image-style-align-left {
        margin-right: calc(1.5em / 2);
    }
    .image-inline.image-style-align-right {
        margin-left: calc(1.5em / 2);
    }
    .image.image_resized {
        max-width: 100%;
        display: block;
        box-sizing: border-box;
    }
    .image.image_resized img {
        width: 100%;
    }
    .image.image_resized > figcaption {
        display: block;
    }
    span[lang] {
        font-style: italic;
    }
    .todo-list {
        list-style: none;
    }
    .todo-list li {
        margin-bottom: 5px;
    }
    .todo-list li .todo-list {
        margin-top: 5px;
    }
    .todo-list .todo-list__label > input {
        -webkit-appearance: none;
        display: inline-block;
        position: relative;
        width: 16px;
        height: 16px;
        vertical-align: middle;
        border: 0;
        left: -25px;
        margin-right: -15px;
        right: 0;
        margin-left: 0;
    }
    .todo-list .todo-list__label > input::before {
        display: block;
        position: absolute;
        box-sizing: border-box;
        content: '';
        width: 100%;
        height: 100%;
        border: 1px solid hsl(0, 0%, 20%);
        border-radius: 2px;
        transition: 250ms ease-in-out box-shadow, 250ms ease-in-out background, 250ms ease-in-out border;
    }
    .todo-list .todo-list__label > input::after {
        display: block;
        position: absolute;
        box-sizing: content-box;
        pointer-events: none;
        content: '';
        left: calc( 16px / 3 );
        top: calc( 16px / 5.3 );
        width: calc( 16px / 5.3 );
        height: calc( 16px / 2.6 );
        border-style: solid;
        border-color: transparent;
        border-width: 0 calc( 16px / 8 ) calc( 16px / 8 ) 0;
        transform: rotate(45deg);
    }
    .todo-list .todo-list__label > input[checked]::before {
        background-color: hsl(126, 64%, 41%);
        border-color: hsl(126, 64%, 41%);
    }
    .todo-list .todo-list__label > input[checked]::after {
        border-color: hsl(0, 0%, 100%);
    }
    .todo-list .todo-list__label .todo-list__label__description {
        vertical-align: middle;
    }
    .media {
        clear: both;
        margin: 0.9em 0;
        display: block;
        min-width: 15em;
    }
    .table {
        margin: 20px auto;
        display: table;
        width: 100%;
    }
    .table table {
        border-collapse: collapse;
        border-spacing: 0;
        width: 100%;
        height: 100%;
    }
    .table table td,
    .table table th {
        min-width: 2em;
        padding: 5px;
        border-left: 1px solid hsl(0, 0%, 75%);
        border-bottom: 1px solid hsl(0, 0%, 75%);
    }
    .table table td:last-child{
        border-left: 1px solid hsl(0, 0%, 75%);
        border-bottom: 1px solid hsl(0, 0%, 75%);
        border-right: 1px solid hsl(0, 0%, 75%);
    }
    .table table th {
        border-top: 1px solid hsl(0, 0%, 75%);
        border-left: 1px solid hsl(0, 0%, 75%);
        border-bottom: 1px solid hsl(0, 0%, 75%);
        font-weight: bold;
        background-color: hsla(0, 0%, 0%, 5%);
    }
    .table table th:last-child{
        border: 1px solid hsl(0, 0%, 75%);
        font-weight: bold;
        background-color: hsla(0, 0%, 0%, 5%);
    }
    [dir='rtl'] .table th {
        text-align: right;
    }
    [dir='ltr'] .table th {
        text-align: left;
    }
    .table > figcaption {
        display: table-caption;
        caption-side: top;
        word-break: break-word;
        text-align: center;
        color: hsl(0, 0%, 20%);
        background-color: hsl(0, 0%, 97%);
        padding: 5px;
        font-size: 13px;
        outline-offset: -1px;
    }
    pre {
        padding: 10px;
        color: hsl(0, 0%, 20.8%);
        background-color: hsla(0, 0%, 78%, 0.3);
        border: 1px solid hsl(0, 0%, 77%);
        border-radius: 2px;
        text-align: left;
        direction: ltr;
        tab-size: 4;
        white-space: pre-wrap;
        font-style: normal;
        min-width: 200px;
        margin-bottom: 20px;
    }
    pre code {
        background-color: transparent !important;
        padding: 0;
        border-radius: 0;
        margin: 0;
    }
    hr {
        margin: 30px 0;
        height: 2px;
        background-color: hsl(0, 0%, 87%);
        border: 0;
    }
    .mention {
        background-color: hsla(341, 100%, 30%, 0.1);
        color: hsl(341, 100%, 30%);
    }
    ol, ul, dl{
        padding-left: 10px;
        margin-bottom: 20px;
    }
    .media{
        width: 100%;
        display: flex;
        margin-top: 15px;
        margin-bottom: 15px;
    }
    .media > div{
        display: flex;
        width: 100%;
    }
    .media > div > div{
        display: flex;
        width: 100%;
    }
    h1 {
        font-size: 2em;
        line-height: 1.2em;
        margin: 0 0 10px 0;
    }
    h2 {
        font-size: 1.5em;
        line-height: 1.2em;
        margin: 0 0 10px 0;
    }
    h3 {
        font-size: 1.3em;
        line-height: 1.2em;
        margin: 0 0 10px 0;
    }
    h4 {
        font-size: 1em;
        line-height: 1.2em;
        margin: 0 0 10px 0;
    }
    h5 {
        font-size: 0.8em;
        line-height: 1.2em;
        margin: 0 0 10px 0;
    }
    h6 {
        font-size: 0.7em;
        line-height: 1.2em;
        margin: 0 0 10px 0;
    }
    </style>""";
}
