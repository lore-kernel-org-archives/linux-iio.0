Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38949 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbcGJNw1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 09:52:27 -0400
Subject: Re: [PATCH 0/9] staging: iio: isl29018 and isl29028 cleanup
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9d566311-b8b9-e4cf-027d-d113cf690582@kernel.org>
Date: Sun, 10 Jul 2016 14:52:19 +0100
MIME-Version: 1.0
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/16 12:55, Peter Meerwald-Stadler wrote:
> cleanup for two staging drivers, prefixing stuff mostly
> 
> Peter Meerwald-Stadler (9):
>   isl29018: Prefix #defines
>   isl29018: Remove excessive output messages
>   isl29018: Drop newlines
>   isl29018: Cleanup of comments
>   isl29018: Prefix remaining functions
>   isl29028: Prefix #defines
>   isl29028: Prefix stuff
>   isl29028: Expose scale and sample frequency available without comma
>   isl29028: Prefix functions
> 
>  drivers/staging/iio/light/isl29018.c |  133 +++++++++++++++-------------------
>  drivers/staging/iio/light/isl29028.c |  102 +++++++++++++-------------
>  2 files changed, 109 insertions(+), 126 deletions(-)
> 
Excellent series.
All applied to the togreg branch of iio.git. Pushed out as testing
for the autobuilders to play with them.

Our staging graduation rate has slowed down somewhat of late.
Still a few bits of my code in there :(
Good to see you are working on these.

Jonathan
