Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43651 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753628Ab1IGRfU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2011 13:35:20 -0400
Date: Wed, 7 Sep 2011 10:35:16 -0700
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] SPI: add ability to say we want a cs change after
 every transfer.
Message-ID: <20110907173515.GF2906@opensource.wolfsonmicro.com>
References: <4E679770.4090008@cam.ac.uk>
 <1315412387-5765-2-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315412387-5765-2-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Sep 07, 2011 at 05:19:42PM +0100, Jonathan Cameron wrote:
> This allows a number of drivers to make use of utility functions
> such spi_write_then_read as well as making use of regmap possible.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

We could add this in regmap if required.
