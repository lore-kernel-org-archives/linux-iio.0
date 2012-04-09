Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:38325 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab2DJGyn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 02:54:43 -0400
Message-ID: <4F83030A.7030202@free-electrons.com>
Date: Mon, 09 Apr 2012 17:40:58 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 3/5] ARM: AT91: Add the ADC to the sam9g20ek board
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com> <1333641684-20325-4-git-send-email-maxime.ripard@free-electrons.com> <20120407032924.GE16641@game.jcrosoft.org>
In-Reply-To: <20120407032924.GE16641@game.jcrosoft.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 07/04/2012 05:29, Jean-Christophe PLAGNIOL-VILLARD a =E9crit :
> On 18:01 Thu 05 Apr     , Maxime Ripard wrote:
>> This patch adds platform data for the AT91 ADC driver support for
>> the AT91SAM9G20-EK board.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Do you have a plan for DT?

My plan was to take a look at it while adding support for the X25 and
X35, presumably this week or next week.

I admit I have not looked much into it for now.

Maxime
--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
