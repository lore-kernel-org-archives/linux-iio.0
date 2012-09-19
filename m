Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35686 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab2ISP5I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Sep 2012 11:57:08 -0400
Received: by obbuo13 with SMTP id uo13so539861obb.19
        for <linux-iio@vger.kernel.org>; Wed, 19 Sep 2012 08:57:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEE_umptNVPOYeTANC4mtAo8AxizmFkrFoa0eLGoLFtTRgWzng@mail.gmail.com>
References: <CAEE_umptNVPOYeTANC4mtAo8AxizmFkrFoa0eLGoLFtTRgWzng@mail.gmail.com>
Date: Wed, 19 Sep 2012 17:57:07 +0200
Message-ID: <CAEE_umoJ-QmmFMkiXE0AvC3cE4PoD2DrsivFa-49jS2L=nG0ZA@mail.gmail.com>
Subject: Fwd: iio_trigger doesn't work
From: Denis Ciocca <denis.ciocca@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everybody,

I write in this mailing list because I have some problems to
understand the trigger event catch and I ask for your help.

I write a little driver for accelerometer and the core driver works,
but now I want to write trigger code. What I understand is that:

1. register iio_trigger;
2. associate iio_trigger to iio_dev;
3. associate pollfunc with iio_alloc_pollfunc to iio_info;

when trigger occuring (in my example at hrtimers), I call
iio_trigger_poll() function and I expect which handler function
declared inside iio_alloc_pollfunc(...) is called.
This does not happen!

What I'm doing wrong?
There is some documentation about this?

Thanks,

Denis
