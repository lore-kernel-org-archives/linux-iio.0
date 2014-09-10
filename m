Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63723 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbaIJULK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 10 Sep 2014 16:11:10 -0400
Date: Wed, 10 Sep 2014 13:11:03 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: IIO <linux-iio@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DEVICE TREE <devicetree@vger.kernel.org>,
	Carlo Caione <carlo@caione.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Alan Cox <alan@linux.intel.com>,
	Jean Delvare <khali@linux-fr.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fugang Duan <B38611@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Sebastian Reichel <sre@debian.org>,
	Johannes Thumshirn <johannes.thumshirn@men.de>,
	Philippe Reynes <tremyfr@yahoo.fr>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: Re: [PATCH v2 2/4] mfd/axp2xx: extend axp20x to support axp288 pmic
Message-ID: <20140910131103.4f0e06fc@ultegra>
In-Reply-To: <20140910091354.GL30307@lee--X1>
References: <1410267775-4683-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1410267775-4683-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <20140910091354.GL30307@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 10 Sep 2014 10:13:54 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> I think adding ACPI support should be in its own patch.
Agree with the rest reviews comments. On this one, I agree I should
take out the non-essential part of the ACPI code. i.e. mfd cell
device for acpi opregion handler driver. Let it be part of opregion
handler driver submission later on.

However, the enumeration part of the ACPI code is essential to support
this device since it is intended to be enumerated under ACPI only, a
customized PMIC for Intel.

Thanks,

Jacob
