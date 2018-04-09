Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54149 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeDIOGB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Apr 2018 10:06:01 -0400
Received: by mail-wm0-f42.google.com with SMTP id 66so13110595wmd.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Apr 2018 07:06:01 -0700 (PDT)
Received: from [10.0.4.19] (34.16-66-87.adsl-static.isp.belgacom.be. [87.66.16.34])
        by smtp.googlemail.com with ESMTPSA id j30sm381027edc.38.2018.04.09.07.05.59
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 07:05:59 -0700 (PDT)
To: linux-iio@vger.kernel.org
From: =?UTF-8?Q?Ga=c3=abtan_Carlier?= <gcembed@gmail.com>
Subject: Add support of Wiegand card reader
Message-ID: <b36429ed-34cb-6f07-13a2-2ef960bd9b42@gmail.com>
Date: Mon, 9 Apr 2018 16:05:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,
I would like to add support of Wiegand card reader [1]. Where can I place it : drivers/iio/access/wiegand.c or drivers/iio/security/wiegand.c?

Thank you for your help?
Best regards,
Gaëtan.

[1] https://en.wikipedia.org/wiki/Wiegand_interface
