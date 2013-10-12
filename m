Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47065 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3JLKth (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:49:37 -0400
Message-ID: <5259376D.2020004@kernel.org>
Date: Sat, 12 Oct 2013 12:50:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 14/20] staging:iio:simple_dummy: Switch to new event
 config interface
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-14-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:11, Lars-Peter Clausen wrote:
> Switch the simple_dummy driver to the new IIO event config interface as the old
> one is going to be removed.

You do undersell the changes here ;)  Lots of better reasons than the old one is going
away.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

