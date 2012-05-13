Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:54295 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab2EMJmA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 May 2012 05:42:00 -0400
Message-ID: <4FAF81E5.8070700@antcom.de>
Date: Sun, 13 May 2012 11:41:57 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:dac:max517: Convert to channel spec
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-2-git-send-email-lars@metafoo.de> <4FAEB14A.8020408@kernel.org> <4FAED9AD.4020803@antcom.de> <4FAF61CF.6070509@metafoo.de> <4FAF79AB.1080906@antcom.de> <4FAF7CDE.8070507@metafoo.de>
In-Reply-To: <4FAF7CDE.8070507@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/12 11:20, Lars-Peter Clausen wrote:
[regarding the "1&2" output]
> You can only set the same value on both
> outputs simultaneously, which I think has not so many practical use-cases.

_If_ you want to switch outputs "simultaneously", it's hard to do with
the max51x chips due to relatively slow I2C communication. Don't have
timing diagrams right now how close you get if you switch the two
outputs directly one after another, though.

But right, it's not highest priority...

> You'd rather want to set two different values on output 1 and 2.

We have and will have attributes for those anyway, don't we?

Roland
