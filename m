Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it1-f182.google.com ([209.85.166.182]:52301 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeLBEEQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Dec 2018 23:04:16 -0500
Received: by mail-it1-f182.google.com with SMTP id i7so3249006iti.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Dec 2018 08:51:20 -0800 (PST)
MIME-Version: 1.0
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sat, 1 Dec 2018 14:51:07 -0200
Message-ID: <CAHd-oW4U-BGs+Enf07SP_XXWDPv4bzOM6KM83FX54gKWpW7hXw@mail.gmail.com>
Subject: Questions about the contributing process
To: linux-iio@vger.kernel.org
Cc: kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello everyone

It's been a few months since I started sending patches, but there are
still some points about the process that I do not quite understand. I
would be really grateful if anyone could help clarify them for me.

1) How do we credit more than one person as an author? Here at the
University of S=C3=A3o Paulo we sometimes develop patches in pair
programming, and I don't really know if in these cases we should just
add the S-o-B of both authors or add the "Co-Developed-by" tag (or
something else). Also, is this something specific to each subsystem?

2) Does iio have a test infrastructure? I know there are autobuilders
playing with the iio.git testing branch, but how does it work? Also,
if there is no test beyond building, is there some plan to make such
an infrastructure in the near future?

3) When a reviewer sends an Acked-by, but I still have to send a v2
for some reason (maybe adjusting the patch message, e.g.), should I
add the Acked-by in v2 or that's something the maintainers will do?

Thank you
Matheus
