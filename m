Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47120 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3JLKwF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:52:05 -0400
Message-ID: <52593804.2040601@kernel.org>
Date: Sat, 12 Oct 2013 12:52:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 17/20] staging:iio:ad799x: Simplify threshold register
 look-up
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-17-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:11, Lars-Peter Clausen wrote:
> Given a channel number the corresponding threshold and hysteresis registers can
> easily be calculated. No need to use a look-up table.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied,
