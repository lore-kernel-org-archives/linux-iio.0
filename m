Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34676 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbcGACUA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 22:20:00 -0400
Date: Thu, 30 Jun 2016 21:19:57 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Peter Rosin <peda@axentia.se>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: Re: [PATCH v3 2/4] iio: potentiometer: mcp4531: Add device tree
 binding documentation
Message-ID: <20160701021957.GA17269@rob-hp-laptop>
References: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1467272091-28087-3-git-send-email-florian.vaussard@heig-vd.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467272091-28087-3-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 30, 2016 at 09:34:49AM +0200, Florian Vaussard wrote:
> Add the device tree documentation for all the supported parts. Apart the
> compatible string and standard I2C binding, no other binding is currently
> needed.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
