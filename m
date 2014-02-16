Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:51099 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885AbaBPSx6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Feb 2014 13:53:58 -0500
Message-ID: <530109DE.3010607@metafoo.de>
Date: Sun, 16 Feb 2014 19:56:30 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC]coding style for NULL pointer checks
References: <5300ACC6.90509@gmx.de>
In-Reply-To: <5300ACC6.90509@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/16/2014 01:19 PM, Hartmut Knaack wrote:
> Hi together,
> I noticed, that many pointers in the IIO subsystem are checked for successful allocation in the way of "if (pointer == NULL)" or "if (pointer != NULL)", while in a few cases the form of simply "if (!pointer)" or "if (pointer)" is used. So, is there any interest in having a more consistent style, and if so, for which one?
> My personal preference is for the latter one.

I think enforcing this is a bit to much nitpicking. So if you clean this up the 
other pattern will probably appear again in new drivers at some point.

Otherwise, if you feel strongly about this, go ahead and send a patch.

- Lars

