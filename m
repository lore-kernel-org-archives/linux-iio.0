Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39925 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1HZWUf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 18:20:35 -0400
Received: by pzk37 with SMTP id 37so4947122pzk.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2011 15:20:35 -0700 (PDT)
Date: Sat, 27 Aug 2011 01:18:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: Grant Grundler <grundler@google.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
Message-ID: <20110826221817.GI3775@shale.localdomain>
References: <20110826011542.GK5975@shale.localdomain>
 <CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It looks good to me, but I don't know anything about the iio code.
Jonathan will let you know if there is a problem.  :)

This is minor thing, but checkpatch complains that:
+#define ISL29018_MAX_REGS              ISL29018_REG_ADD_DATA_MSB+1
should be written as:
+#define ISL29018_MAX_REGS              (ISL29018_REG_ADD_DATA_MSB + 1)

Thanks Grant.

regards,
dan carpenter
