Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61759 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab2FUJUl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jun 2012 05:20:41 -0400
Received: by yenl2 with SMTP id l2so265788yen.19
        for <linux-iio@vger.kernel.org>; Thu, 21 Jun 2012 02:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAfyv36oD+mNrXhx1yDqnUpPT=Caecoc=oBhUTGjPNF9Rwdc3w@mail.gmail.com>
References: <CAAfyv36oD+mNrXhx1yDqnUpPT=Caecoc=oBhUTGjPNF9Rwdc3w@mail.gmail.com>
Date: Thu, 21 Jun 2012 14:50:40 +0530
Message-ID: <CAM=Q2cs3YR-WNrojp=nZzE9-n2Y1jXpMn-yjgkVtac=ROfiDTQ@mail.gmail.com>
Subject: Re: reading data from hmc5883
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 21, 2012 at 2:53 AM, Belisko Marek <marek.belisko@gmail.com> wrote:
> Hi,
>
> I'm runnig 3.5-rc2 kernel on my board with hmc5883 magnetometer.
> I've check iio documentation but cannot figure out how to read data from
> device. Node /dev/iio:device0 is properly created.
> I try both test programs: generic_buffer and iio_event_monitor but
> both gives me an error:
> iio_event_monitor:
> ./iio_monitor hmc5883
> Found IIO device with name hmc5883 with device number 0
> Failed to read event from device: Bad file descriptor
>
> IMO this is because hmc5883 don't have event_attrs set and then this fail.
>
> generic_buffer:
> ./generic -n hmc5883
> iio device number being used is 0
> Failed to find the trigger hmc5883-dev0
>
> Not sure about that one but seems trigger is missing (hmc5883 use
> INDIO_DIRECT_MODE)
>
> Is there other way how to read data from device or only possibility is
> by reading sysfs (no polling ?) ?
> Or it is just simple open device -> sleep on poll and when wake -> read data?

If that is all you need how about doing that in userspace?

>
> Thanks in advance,
