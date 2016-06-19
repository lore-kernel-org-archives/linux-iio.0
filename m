Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:53971 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbcFSJlZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 05:41:25 -0400
Subject: Re: [PATCH 1/1] staging: iio: initialize data pointer before using it
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
References: <20160618211224.23183-1-nicolas.iooss_linux@m4x.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <576668B7.8080609@metafoo.de>
Date: Sun, 19 Jun 2016 11:41:11 +0200
MIME-Version: 1.0
In-Reply-To: <20160618211224.23183-1-nicolas.iooss_linux@m4x.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/18/2016 11:12 PM, Nicolas Iooss wrote:
> ad7606_spi_read_block() reads SPI big-endian data into a buffer which is
> then converted to CPU byte-order with a second variable.  This variable,
> data, has been left unitialized after commit 87787e5ef727 ("Staging:
> iio: Fix sparse endian warning").

Hi,

Thanks for the patch. A similar patch was already merged last week.

- Lars
