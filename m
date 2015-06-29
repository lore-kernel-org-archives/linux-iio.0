Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50490 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752078AbbF2SJR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jun 2015 14:09:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CA80B202D7
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2015 14:09:16 -0400 (EDT)
Date: Mon, 29 Jun 2015 21:09:15 +0300
From: Sergei Zviagintsev <sergei@s15v.net>
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: Add support for TXC PA12 als and
 proximity sensor
Message-ID: <20150629180915.GA17917@localhost.localdomain>
References: <1435596828-10436-1-git-send-email-adriana.reus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435596828-10436-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Mon, Jun 29, 2015 at 07:53:48PM +0300, Adriana Reus wrote:
[...]
> +struct {
> +	u8 reg;
> +	u8 val;
> +} regvals[] = {
> +	{PA12203001_REG_CFG0, PA12203001_REG_CFG0_DEFAULT},
> +	{PA12203001_REG_CFG1, PA12203001_REG_CFG1_DEFAULT},
> +	{PA12203001_REG_CFG2, PA12203001_REG_CFG2_DEFAULT},
> +	{PA12203001_REG_CFG3, PA12203001_REG_CFG3_DEFAULT},
> +	{PA12203001_REG_PSET, PA12203001_PSCAN},
> +};

It seems like `static' keyword is missed here.
