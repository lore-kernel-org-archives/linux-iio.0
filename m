Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db3on0125.outbound.protection.outlook.com ([157.55.234.125]:3488
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751728AbcF3HqU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 30 Jun 2016 03:46:20 -0400
In-Reply-To: <1467272091-28087-4-git-send-email-florian.vaussard@heig-vd.ch>
References: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch> <1467272091-28087-4-git-send-email-florian.vaussard@heig-vd.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v3 3/4] iio: potentiometer: mcp4531: Add device tree binding
From: Peter Rosin <peda@axentia.se>
Date: Thu, 30 Jun 2016 09:46:09 +0200
To: Florian Vaussard <florian.vaussard@gmail.com>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Message-ID: <65595556-53E0-4105-892F-A766EDBA2198@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On June 30, 2016 9:34:50 AM GMT+02:00, Florian Vaussard <florian.vaussard@gmail.com> wrote:
>This patch adds the necessary device tree binding to allow DT probing
>of
>currently supported parts.
>
>Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
