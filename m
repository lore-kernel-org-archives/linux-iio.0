Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56810 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174Ab3AYSFP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jan 2013 13:05:15 -0500
Date: Fri, 25 Jan 2013 10:05:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Denis CIOCCA <denis.ciocca-qxv4g6HH51o@public.gmane.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:common: Add STMicroelectronics common driver
Message-ID: <20130125180529.GA29700@roeck-us.net>
References: <1354623414-10742-1-git-send-email-denis.ciocca@st.com>
 <1354623414-10742-2-git-send-email-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354623414-10742-2-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 04, 2012 at 01:16:54PM +0100, Denis CIOCCA wrote:
> This patch adds generic common code driver for STMicroelectronics
> accelerometers, gyroscopes, currently it supports:
> LSM303DLH, LSM303DLHC, LIS3DH, LIS331DLH, LSM303DL, LSM303DLM,
> L3G4200D, LSM330DL, L3GD20, L3GD20H, LSM330D, LSM330DLC, LSM9DS0,
> L3G4IS, LSM330

[ ... ]

> +#define ST_SENSORS_TX_MAX_LENGHT		2
> +#define ST_SENSORS_RX_MAX_LENGHT		6

s/LENGHT/LENGTH/g

Guenter
