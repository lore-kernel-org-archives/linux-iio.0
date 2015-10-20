Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42055 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982AbbJTReW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 20 Oct 2015 13:34:22 -0400
Date: Tue, 20 Oct 2015 10:34:18 -0700
From: Tony Lindgren <tony@atomide.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marek Belisko <marek@goldelico.com>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Message-ID: <20151020173418.GL3078@atomide.com>
References: <cover.1445000017.git.hns@goldelico.com>
 <05c57453151c9e2cbd3f15145f1e15223410cd87.1445000017.git.hns@goldelico.com>
 <20151020162425.GH3078@atomide.com>
 <A872C46B-C0CF-4C67-9615-0A46EDAE9A57@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A872C46B-C0CF-4C67-9615-0A46EDAE9A57@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [151020 09:48]:
> 
> We have our own OMAP5 board in the pipeline and there it will help
> as well to rebase it using arch/arm/boot/dts/omap5-board-common.dts

Yes and then we can hopefully fix up the regulators properly and get
rid of the fixed-regulator flags..

Regards,

Tony
