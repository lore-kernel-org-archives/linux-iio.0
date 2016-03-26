Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:36504 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752679AbcCZT7B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Mar 2016 15:59:01 -0400
Message-ID: <1459022336.23450.7.camel@perches.com>
Subject: Re: [PATCH] staging: iio: convert bare unsigned usage to unsigned
 int
From: Joe Perches <joe@perches.com>
To: Alison Schofield <amsfield22@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Date: Sat, 26 Mar 2016 12:58:56 -0700
In-Reply-To: <20160326195012.GA13368@d830.WORKGROUP>
References: <20160326195012.GA13368@d830.WORKGROUP>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2016-03-26 at 12:50 -0700, Alison Schofield wrote:
> Use kernel preferred unsigned int declaration style.
> 
> Patch created using:
> git ls-files drivers/staging/iio | \
> xargs ./scripts/checkpatch.pl -f --fix-inplace --types=unspecified_int
> 
> Hand edits restored columns in structure definitions.

This all seems reasonable and it's good you redid the columns.
checkpatch isn't smart for that.
