Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38089 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeCXM03 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Mar 2018 08:26:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id m13so1255556wrj.5
        for <linux-iio@vger.kernel.org>; Sat, 24 Mar 2018 05:26:29 -0700 (PDT)
Received: from [192.168.43.226] ([196.137.6.42])
        by smtp.gmail.com with ESMTPSA id l11sm10040777wrg.71.2018.03.24.05.26.26
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 05:26:27 -0700 (PDT)
To: linux-iio@vger.kernel.org
From: Mahmoud Nagy <mnagy1312@gmail.com>
Subject: Can't enable IIO_DUMMY_EVGEN for compiling
Message-ID: <b69d3da4-7c7b-5f00-6a77-81d11f6b52f9@gmail.com>
Date: Sat, 24 Mar 2018 14:26:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

So I'm starting with IIO_tasks,
and I have a little problem,
It seems I can't enable IIO_DUMMY_EVGEN config, nconfig gives "XXX" next
to it, I enabled every other config that is needed for task1, maybe for
a certain dependency that I can't see or something.
need help please.

