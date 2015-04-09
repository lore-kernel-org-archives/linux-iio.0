Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51178 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbbDILNL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:13:11 -0400
Message-ID: <55265ECB.5020500@kernel.org>
Date: Thu, 09 Apr 2015 12:13:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Fixes for the mma9553 driver
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 15:37, Irina Tirdea wrote:
> This is a set of follow-up patches for the mma9553 driver that fixes
> some issues as suggested by Hartmut.
> 
> I have also added the enable channel for activity as suggested by Daniel.
> 
> Irina Tirdea (8):
>   iio: accel: mma9553: coding style fixes
>   iio: accel: mma9553: use unsigned counters
>   iio: accel: mma9553: fix gpio bitnum init value
>   iio: accel: mma9553: refactor mma9553_read_activity_stepcnt
>   iio: accel: mma9553: refactor mma9553_read_raw
>   iio: accel: mma9553: check input value for activity period
>   iio: accel: mma9551_core: prevent buffer overrun
>   iio: accel: mma9553: add enable channel for activity
> 
>  drivers/iio/accel/mma9551_core.c |  58 ++++++----
>  drivers/iio/accel/mma9551_core.h |   2 +-
>  drivers/iio/accel/mma9553.c      | 227 +++++++++++++++++----------------------
>  3 files changed, 136 insertions(+), 151 deletions(-)
> 
Hi Irina,

We've missed the merge window, so these are going to mostly hit one cycle
after the original driver posting.

As such can you reorder the patches to pull all the bug fixes to the beginning
as they can go into 4.1 whereas the style fixes etc will go into 4.2
