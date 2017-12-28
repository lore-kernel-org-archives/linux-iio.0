Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35403 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdL1LkZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Dec 2017 06:40:25 -0500
Received: by mail-wr0-f194.google.com with SMTP id l19so26594513wrc.2
        for <linux-iio@vger.kernel.org>; Thu, 28 Dec 2017 03:40:24 -0800 (PST)
Date: Thu, 28 Dec 2017 12:40:21 +0100
From: Stefan Tatschner <stefan.tatschner@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio/bmp280-core.c: Read calibration data in probe
Message-ID: <20171228114021.GA23073@kronos>
References: <20171212180610.GF2590@arbeit>
 <20171212203537.8204-1-stefan.tatschner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212203537.8204-1-stefan.tatschner@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Tue, Dec 12, 2017 at 09:35:37PM +0100, Stefan Tatschner wrote:
> This patch affects BME280 and BMP280. The readout of the calibration
> data is moved to the probe function. Each sensor data access triggered
> reading the full calibration data before this patch. According to the
> datasheet, Section 4.4.2., the calibration data is stored in non-volatile
> memory.
> 
> Since the calibration data does not change, and cannot be changed by the
> user, we can reduce bus traffic by reading the calibration data once.
> Additionally, proper organization of the data types enables removing
> some odd casts in the compensation formulas.
> 
> Signed-off-by: Stefan Tatschner <stefan.tatschner@gmail.com>

what's the status of this? Are there any further opinions on this?  I am
happy to address your comments on my first kernel patch. :)

Stefan

> ---
> 
> v2 changes:
>     - readded the type casts in humidity calibration values
>     - fix typo
> 
>  drivers/iio/pressure/bmp280-core.c | 205 ++++++++++++++++++++++++-------------
>  1 file changed, 134 insertions(+), 71 deletions(-)
