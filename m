Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 17 Oct 2011 11:46:42 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	zdevai@gmail.com
Subject: Re: [PATCH] staging:iio:proof of concept in kernel interface.
Message-ID: <20111017104642.GD3042@opensource.wolfsonmicro.com>
References: <1318333383-17663-1-git-send-email-jic23@cam.ac.uk>
 <1318333383-17663-2-git-send-email-jic23@cam.ac.uk>
 <20111013143224.GO1098@sirena.org.uk>
 <4E96F9AC.9000001@cam.ac.uk>
 <20111013204410.GA17160@sirena.org.uk>
 <4E985C60.9020308@cam.ac.uk>
 <CAKnu2MrUkY2upFh5d6GGTNUr-=r_JKcxh5OQNV63bdOCa4F+zg@mail.gmail.com>
 <4E9BF8D9.8030301@cam.ac.uk>
 <20111017101959.GC3042@opensource.wolfsonmicro.com>
 <4E9C0423.5010909@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E9C0423.5010909@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 17, 2011 at 11:32:03AM +0100, Jonathan Cameron wrote:

> Initially I'd be tempted to only support numbered channels (on adc side).
> Later we can add the named option - iff it has real use cases.

I think the PMIC case is a real one, assigning numbers people need to
use to find things is doesn't really reflect actual usage.
