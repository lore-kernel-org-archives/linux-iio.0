Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45445 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab2EIJzy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 05:55:54 -0400
Received: by lbbgm6 with SMTP id gm6so55452lbb.19
        for <linux-iio@vger.kernel.org>; Wed, 09 May 2012 02:55:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net>
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net>
Date: Wed, 9 May 2012 15:25:52 +0530
Message-ID: <CAM=Q2cuuki_4jJoCdLOrdHVVk-yKSOyaLL3dcbY_SzxJXvt8Kg@mail.gmail.com>
Subject: Re: iio: v2, add support for HMC5883/HMC5883L to HMC5843 driver
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

On Wed, May 9, 2012 at 3:49 AM, Peter Meerwald <pmeerw@pmeerw.net> wrot=
e:
> here is my updated patch series to extend the HMC5843 magnetometer
> driver to support the HMC5883/HMC5883L devices
>
> patch 1 fixes access issues to the hmc5843 private data,
> patches 2 to 7 are preparatory patches,
> patch 8 actually brings in the support for the new devices
>
> the timeout in the read loop has not yet been implemented (suggestion=
s by
> Lars-Peter Clausen)
>
> the driver has a severe limitation: X/Y/Z must ALL be read to allow n=
ew
> data to become available (the device goes into a locked state until a=
ll
> are read)

Thats a limitation comming from the data sheet right?

Are you suggesting a read all and report only requested?
to work round that.

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
