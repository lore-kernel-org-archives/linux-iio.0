Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34038 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab2DXIMk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Apr 2012 04:12:40 -0400
Message-ID: <4F966076.2070402@kernel.org>
Date: Tue, 24 Apr 2012 09:12:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC] Add frequency support in trigger core
References: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/19/2012 5:05 PM, Maxime Ripard wrote:
> Hi List,
>
> A lot of driver add an extra frequency attribute to allow user to tune
> triggers frequency from sysfs. This is a lot of code duplication, while most
> do the exact same thing.
>
> I added here two extra fields to struct iio_trigger, frequency and info_mask,
> which might not be needed at first, but will allow us to add extra parameters
> more easily.
>
> I added as well a callback for info_mask changes in trigger_ops so that drivers
> can take action when frequency has been changed by the user, but will also be
> easily extendable.
I'm generally in favour of this as it'll make in kernel accesses to 
these controls easier to add.

