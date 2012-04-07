Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:46195 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751060Ab2DGFDd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Apr 2012 01:03:33 -0400
Received: from mail622.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 5F63AFF88A4
	for <linux-iio@vger.kernel.org>; Sat,  7 Apr 2012 05:46:43 +0200 (CEST)
Date: Sat, 7 Apr 2012 05:29:24 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 3/5] ARM: AT91: Add the ADC to the sam9g20ek board
Message-ID: <20120407032924.GE16641@game.jcrosoft.org>
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
 <1333641684-20325-4-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333641684-20325-4-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18:01 Thu 05 Apr     , Maxime Ripard wrote:
> This patch adds platform data for the AT91 ADC driver support for
> the AT91SAM9G20-EK board.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Do you have a plan for DT?

Best Regards,
J.
