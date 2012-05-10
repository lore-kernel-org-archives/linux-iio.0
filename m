Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44502 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab2EJOTF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 10:19:05 -0400
Received: by eeit10 with SMTP id t10so555386eei.19
        for <linux-iio@vger.kernel.org>; Thu, 10 May 2012 07:19:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAM=Q2csFuVULPim9gE8YnVLCDmJDFTuSFPWwrUmM29yR=LpCEQ@mail.gmail.com>
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net>
	<1336515606-12364-2-git-send-email-pmeerw@pmeerw.net>
	<CAM=Q2csFuVULPim9gE8YnVLCDmJDFTuSFPWwrUmM29yR=LpCEQ@mail.gmail.com>
Date: Thu, 10 May 2012 19:49:03 +0530
Message-ID: <CAM=Q2cvao+=KiRxstq9d0KyyApo-mbrP8UkFWmky+VjGtPdE9w@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: fix access to hmc5843 private data
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>
> On Wed, May 9, 2012 at 3:49 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> From: Peter Meerwald <p.meerwald@bct-electronic.com>
>>
>> i2c_get_clientdata(client) points to iio_dev, not hmc5843_data; fixes
>> issue similar to 62d2feb9803f18c4e3c8a1a2c7e30a54df8a1d72
>>
> Looks good to me ack.
(correcting the ack format)
Acked-by:  Shubhrajyoti D <shubhrajyoti@ti.com>
