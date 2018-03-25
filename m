Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33810 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeCYOGZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Mar 2018 10:06:25 -0400
Received: by mail-wm0-f52.google.com with SMTP id a20so13134211wmd.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Mar 2018 07:06:24 -0700 (PDT)
Received: from [192.168.1.103] ([197.52.163.206])
        by smtp.gmail.com with ESMTPSA id p68sm14569294wmg.7.2018.03.25.07.06.22
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 07:06:22 -0700 (PDT)
To: linux-iio@vger.kernel.org
From: Mahmoud Nagy <mnagy1312@gmail.com>
Subject: Duplicate scan index 4!
Message-ID: <d4d848a1-45c7-90fb-52b8-ee64dbe3e710@gmail.com>
Date: Sun, 25 Mar 2018 16:06:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Why do I get "Duplicate scan index 4" from dummy iio after adding a new
scan element for task 3 "DUMMY_INDEX_MAGNX"?

