Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60625 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab1K2SGD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Nov 2011 13:06:03 -0500
Date: Tue, 29 Nov 2011 18:05:53 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alessandro Rubini <rubini@gnudd.com>, jic23@kernel.org,
	federico.vaga@gmail.com, linux-iio@vger.kernel.org, greg@kroah.com
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there
 requirements [was Re: Industrial Input Output analysis]
Message-ID: <20111129180553.GD12111@sirena.org.uk>
References: <4ED36B93.5020703@metafoo.de>
 <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com>
 <4ED21960.1000002@kernel.org>
 <20111129110013.GA27762@mail.gnudd.com>
 <4ED4ECAF.3040906@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ED4ECAF.3040906@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 29, 2011 at 03:31:11PM +0100, Lars-Peter Clausen wrote:
> On 11/29/2011 12:00 PM, Alessandro Rubini wrote:

> > Overlap happens. I don't see it as a problem. You overlap with
> > linux-sensors already, and everything overlaps with generic char
> > devices.

> I just think it's a waste of resources to develop two frameworks which have
> more or less the same architecture and serve the same purpose.

It's also problematic for driver authors if we end up having to work
with two separate frameworks that fulfil the same function depending on
which application users end up using.
