Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:57993 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab1KHNTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2011 08:19:24 -0500
Date: Tue, 8 Nov 2011 14:19:10 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
Message-ID: <20111108141910.53f6b861@skate>
In-Reply-To: <1320682113-23655-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320682113-23655-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320682113-23655-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le Mon,  7 Nov 2011 17:08:31 +0100,
Maxime Ripard <maxime.ripard@free-electrons.com> a =C3=A9crit :

> +/* ADC */
> +struct at91_adc_data {
> +	/* ADC Clock as specified by the datasheet, in Hz. */
> +	unsigned int adc_clock;
> +	/*
> +	 * Global number of channels available (to specify which channels a=
re
> +	 * indeed used on the board, see the channels_used array).

channels_used is no longer an array, but a bitmap.

Regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
