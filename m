Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50815 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbaKFOzw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Nov 2014 09:55:52 -0500
Message-ID: <1415285707.7630.36.camel@hadess.net>
Subject: Re: Kernel wishlist item: Better IIO API
From: Bastien Nocera <hadess@hadess.net>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Date: Thu, 06 Nov 2014 15:55:07 +0100
In-Reply-To: <CAEnQRZArfFXnyRkRfM7bSO8o=hpQx1i3FhJy7SCmaZpBzgmGXQ@mail.gmail.com>
References: <1414593052.2406.37.camel@hadess.net>
	 <5451221D.6000301@metafoo.de> <1414604035.2406.41.camel@hadess.net>
	 <54512640.3040505@metafoo.de> <1414604840.2406.43.camel@hadess.net>
	 <54513238.6050903@metafoo.de> <1415055709.4506.19.camel@hadess.net>
	 <CAEnQRZAA7bN999XUmj3kaH2U3dPET0NRXDcFNprxZLAZS=ARzg@mail.gmail.com>
	 <1415089663.4506.26.camel@hadess.net>
	 <CAEnQRZBoTbQMCC1+qwewUefk1u616pLrhUD+i5WhoZ0Se+2fWQ@mail.gmail.com>
	 <1415090732.4506.28.camel@hadess.net>
	 <CAEnQRZArfFXnyRkRfM7bSO8o=hpQx1i3FhJy7SCmaZpBzgmGXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2014-11-04 at 10:56 +0200, Daniel Baluta wrote:
> On Tue, Nov 4, 2014 at 10:45 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Tue, 2014-11-04 at 10:37 +0200, Daniel Baluta wrote:
> >> On Tue, Nov 4, 2014 at 10:27 AM, Bastien Nocera <hadess@hadess.net> wrote:
> >> > On Tue, 2014-11-04 at 10:18 +0200, Daniel Baluta wrote:
> >> >> On Tue, Nov 4, 2014 at 1:01 AM, Bastien Nocera <hadess@hadess.net> wrote:
<snip>
> >> >> > Finally, there's some documentation, and it's not quite finished, or
> >> >> > there's something fishy on this device:
> >> >> > $ ls /sys//devices/platform/80860F41:04/i2c-12/i2c-SMO8500:00/iio:device0/events
> >> >> > in_accel_x_thresh_thresh_en      in_accel_x_thresh_thresh_value
> >> >> > in_accel_y_thresh_thresh_period  in_accel_z_thresh_thresh_en
> >> >> > in_accel_z_thresh_thresh_value
> >> >> > in_accel_x_thresh_thresh_period  in_accel_y_thresh_thresh_en
> >> >> > in_accel_y_thresh_thresh_value   in_accel_z_thresh_thresh_period
<snip>
> I forgot that SMO8500 is KXCJ9.
> 
> Should work with https://lkml.org/lkml/2014/10/10/249 :).

$ ls events/
in_accel_x_thresh_either_en      in_accel_x_thresh_either_value
in_accel_y_thresh_either_period  in_accel_z_thresh_either_en
in_accel_z_thresh_either_value
in_accel_x_thresh_either_period  in_accel_y_thresh_either_en
in_accel_y_thresh_either_value   in_accel_z_thresh_either_period

Yeah, better.

