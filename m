Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:47773 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab2JWKcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2012 06:32:14 -0400
Subject: Re: i.MX28 die temperature
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Peter Turczak <peter@turczak.de>
In-Reply-To: <201210231052.39983.marex@denx.de>
Date: Tue, 23 Oct 2012 12:22:54 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Message-Id: <81D7F19D-A9F8-4022-81F0-B8A836F7F087@turczak.de>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201206271400.11727.marex@denx.de> <6E339FB7-3B7F-4D90-A472-D375F36755F1@netconsequence.de> <201210231052.39983.marex@denx.de>
To: Marek Vasut <marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Oct 23, 2012, at 10:52 AM, Marek Vasut wrote:
> We have some basic LRADC driver in upstream already, you should use that.
> 
> See drivers/staging/iio/adc/mxs-lradc.c
Thanks for the heads-up.
I was referring to this driver (pulled from linus' 3.7rc), it does not currently seem to have a consumer api for use within other kernel modules. Maybe I'm just heading the wrong way now...

Best regards,
  Peter
