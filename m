Return-Path: <lars@metafoo.de>
Message-ID: <56052F05.90807@metafoo.de>
Date: Fri, 25 Sep 2015 13:24:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>, Michael.Hennerich@analog.com,
 jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad799x: leave sysfs naming to the core
References: <1443174841-25782-1-git-send-email-martink@posteo.de>
In-Reply-To: <1443174841-25782-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 09/25/2015 11:54 AM, Martin Kepplinger wrote:
> This shouldn't change anything since the core calls the events folder
> "events" anyways.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
