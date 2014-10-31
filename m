Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51793 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759081AbaJaLmq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Oct 2014 07:42:46 -0400
Date: Fri, 31 Oct 2014 13:43:11 +0200
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: IIO <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3]iio:pressure:bmp280: fix pressure calculation
Message-ID: <20141031114311.GA24473@vdogaru>
References: <5452E454.8040607@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5452E454.8040607@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 31, 2014 at 02:22:28AM +0100, Hartmut Knaack wrote:
> According to the datasheet and as defined in struct bmp280_comp_press, dig_p1 is
> of type u16, while dig_p2 to dig_p9 are of type s16. In
> bmp280_read_compensation_press(), values read from the device were treated as
> the wrong type.
> In bmp280_read_press() the fractional part of the measured pressure is
> calculated wrong. A better way is to use *val for the raw pressure and *val2 for
> the quotient and let the core do the proper conversion using IIO_VAL_FRACTIONAL.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Vlad Dogaru <vlad.dogaru@intel.com>
