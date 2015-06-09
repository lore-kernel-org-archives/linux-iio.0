Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:52969 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbFIRMa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jun 2015 13:12:30 -0400
Message-ID: <3e2df3769656eb8b7eb448e9a540e30f.squirrel@mungewell.org>
In-Reply-To: <1433843657.12204.18.camel@hadess.net>
References: <02179134fef3a932cff19b793006f020.squirrel@mungewell.org>
    <1433843657.12204.18.camel@hadess.net>
Date: Tue, 9 Jun 2015 13:12:29 -0400
Subject: Re: Handling Controllers with Acc/Gyro/Mag via HID system
From: simon@mungewell.org
To: "Bastien Nocera" <hadess@hadess.net>
Cc: simon@mungewell.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	"Frank Praznik" <frank.praznik@oh.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> The IIO subsystem's user-space API is awful, and root only. I said as
> much here:
> http://thread.gmane.org/gmane.linux.kernel.iio/14421

Just getting started with this idea, and found this which might waylay
some of the pain....
https://github.com/analogdevicesinc/libiio


> I wrote this for accelerometers that are in tablets/convertibles:
> https://github.com/hadess/iio-sensor-proxy/

Thanks I'll check it out. Thinking more of a AHRS rather than 'just'
rotating the screen. ;-)
Simon

