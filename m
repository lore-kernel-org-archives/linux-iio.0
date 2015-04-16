Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33612 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbbDPMBQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2015 08:01:16 -0400
Received: by wiax7 with SMTP id x7so10009864wia.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2015 05:01:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150416115111.613FC405F1@saturn.retrosnub.co.uk>
References: <BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40@BN1PR0301MB0612.namprd03.prod.outlook.com>
	<20150416115111.613FC405F1@saturn.retrosnub.co.uk>
Date: Thu, 16 Apr 2015 15:01:15 +0300
Message-ID: <CAEnQRZB-qDTJuPakF6iKynNp0eYCjh-WryodfHzkOWPtGd1CGA@mail.gmail.com>
Subject: Re: Advice needed on combination sensor driver implementation
From: Daniel Baluta <daniel.baluta@gmail.com>
To: jic23@jic23.retrosnub.co.uk
Cc: "utkarsh.gupta@freescale.com" <utkarsh.gupta@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 16, 2015 at 2:51 PM,  <jic23@jic23.retrosnub.co.uk> wrote:
> utkarsh.gupta@freescale.com writes:
>>
>> Hello,
>> I am looking at implementing FXOS8700 driver, which consists of an
>> accelerometer and magnetometer, into the linux kernel 4.0. This device can
>> function independently as accel and magnetometer however it has been
>> recommended to implement it as one driver in order to achieve consistency
>> and synchronized functionality of both modules.
>> Please advice on whether this driver could be implemented as
>> accel_magnetometer combined driver in a separate folder in iio? Or should
>> this be implemented as separate accel and magnetometer modules in their
>> corresponding existing folders in iio?
>
>
> Hi, Just been reading the datasheet over lunch.  This is a bit more
> interesting than the usual approach of simply putting two bits of silicon
> into one package, and the two sensors are tightly coupled.
> As such it's similar to the full IMUs such as the ADIS16400 and similar.
> Anyhow, definitely a unified driver. Location wise, I'm tempted to suggest
> we rename the IMU directory as 'combined' or something similar and drop
> all properly integrated multiple sensor devices in there.

s/combined/combo would be better.

Daniel.
