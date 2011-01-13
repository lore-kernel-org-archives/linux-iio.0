Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:54967 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757316Ab1AMRlJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 13 Jan 2011 12:41:09 -0500
Message-ID: <4D2F3933.1050401@antcom.de>
Date: Thu, 13 Jan 2011 18:41:07 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Roland Stigge <rst@work-microwave.de>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fixpoint formatted output bugfix
References: <1294908733-20354-1-git-send-email-rst@work-microwave.de> <4D2EDD50.7060508@cam.ac.uk> <20110113164938.GA27468@kroah.com>
In-Reply-To: <20110113164938.GA27468@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/13/2011 05:49 PM, Greg KH wrote:
>> Greg, this is a simple bug fix. The ad7476 and ad799x are in 2.6.37
>> so it would be good to push this to stable as well.
>> Do you want a broken out patch with just those two in it?
> 
> Yes, that would be great to have, can you split this into 2 different
> patches so I can handle it that way easier?

I'm sending the 2.6.37 version in a separate patch.

Roland
