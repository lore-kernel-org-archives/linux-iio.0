Return-Path: <joe@perches.com>
Message-ID: <1379923836.3575.19.camel@joe-AO722>
Subject: Re: [PATCH] iio: add Bosch BMG160 gyroscope sensor driver
From: Joe Perches <joe@perches.com>
To: jianlong <jianlong.gao@cn.bosch.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,  ji.chen@cn.bosch.com, yunfei.ma2@cn.bosch.com
Date: Mon, 23 Sep 2013 01:10:36 -0700
In-Reply-To: <1379914517-2491-1-git-send-email-jianlong.gao@cn.bosch.com>
References: <1379914517-2491-1-git-send-email-jianlong.gao@cn.bosch.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mon, 2013-09-23 at 13:35 +0800, jianlong wrote:
> This patch adds IIO driver for Bosch BMG160 triaxial gyroscope sensor.

This code could be made a lot more readable
without the somewhat obfuscating 16 bit
compiler support.

Are there similar devices that this source
needs to support in the future or should this
code be converted to a more linux style?
