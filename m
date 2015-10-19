Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-193.synserver.de ([212.40.185.193]:1121 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751107AbbJSL5h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 07:57:37 -0400
Message-ID: <5624DAAB.9040207@metafoo.de>
Date: Mon, 19 Oct 2015 13:57:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	=?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
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
Subject: Re: [PATCH v3 2/3] iio:adc:palmas: add DT support
References: <cover.1445000017.git.hns@goldelico.com> <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns@goldelico.com>
In-Reply-To: <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns@goldelico.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/2015 02:53 PM, H. Nikolaus Schaller wrote:
[...]
> +Optional sub-nodes:
> +ti,channel0-current-microamp: Channel 0 current in uA.
> +	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
> +ti,channel3-current-microamp: Channel 3 current in uA.
> +	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
> +ti,enable-extended-delay: Enable extended delay.

Those three above sound more like configuration policy, rather than hardware
description. What influence which values should be chosen?


