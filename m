Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34254 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcD0O4N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2016 10:56:13 -0400
MIME-Version: 1.0
In-Reply-To: <1461674398-18374-1-git-send-email-daniel.baluta@intel.com>
References: <1461674398-18374-1-git-send-email-daniel.baluta@intel.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Wed, 27 Apr 2016 11:55:52 -0300
Message-ID: <CAKi4VA+JgdEa9owULm_hg8fiJGMCwv286y-0J-rRX_Ukups8QQ@mail.gmail.com>
Subject: Re: [RFT PATCH] iio: magn: Add support for BMM150 magnetometer
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 26, 2016 at 9:39 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> BMM150 is register compatible with magnetometer part of
> BMC156.
>
> Datasheet is at:
> http://www.mouser.com/ds/2/783/BST-BMM150-DS001-01-786480.pdf
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
> Lucas let me know if it works for you. I don't have yet the BMM150 evaluation
> board. It should be available in few weeks.
>
> I'll just leave this patch here in case anyone steps in to test it.

It will take a while for my test board to arrive here, so expect delay
on testing this.

thanks
Lucas De Marchi
