Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59012 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966119AbcIHQHb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Sep 2016 12:07:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u88G5OEB009678
        for <linux-iio@vger.kernel.org>; Thu, 8 Sep 2016 18:07:24 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-.pphosted.com with ESMTP id 257nde2xsq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 08 Sep 2016 18:07:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D4F93A
        for <linux-iio@vger.kernel.org>; Thu,  8 Sep 2016 16:07:23 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas4.st.com [10.75.90.69])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6949277A
        for <linux-iio@vger.kernel.org>; Thu,  8 Sep 2016 16:07:23 +0000 (GMT)
To: <linux-iio@vger.kernel.org>
CC: Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
        Denis CIOCCA <denis.ciocca@st.com>
From: Armando Visconti <armando.visconti@st.com>
Subject: question about IIO buffer interface
Message-ID: <e388b0fd-85a9-16d6-5ec9-28021f5a5f64@st.com>
Date: Thu, 8 Sep 2016 18:07:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm using kernel 3.10, but question is valid for any kernel
version.

I'm not able to clearly understand how the pre/post enable/disable
routines should be implemented in the IIO driver for my sensor.

In particular, it is not clear to me where I should be expected
to put the enable/disable of the sensor.

Looking at following comments inside include/linux/iio/iio.h, it
seems to me that maybe the sensor enable should be put inside
the postenable, and the sensor disabled inside the predisabled.

> * @preenable:        [DRIVER] function to run prior to marking buffer enabled
> * @postenable:       [DRIVER] function to run after marking buffer enabled
> * @predisable:       [DRIVER] function to run prior to marking buffer
> *                    disabled
> * @postdisable:      [DRIVER] function to run after marking buffer disabled

But it is not so evident looking at the IIO framework.
Can someone put some light on it?

Thx,
Armando
