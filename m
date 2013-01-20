Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41717 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATMKu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Jan 2013 07:10:50 -0500
Message-ID: <50FBDEC8.1040703@kernel.org>
Date: Sun, 20 Jan 2013 12:10:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, jbrenner@taosinc.com
Subject: Re: [PATCH 0/3 V2]  staging:iio:tsl2583 update interfaces
References: <1357987339-11800-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1357987339-11800-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jon,

Any chance you could have a look at these? No particular
rush though...

Jonathan
On 01/12/2013 10:42 AM, Jonathan Cameron wrote:
> Final patch fixed so it doesn't contain a typo that prevents it compiling.
> Sorry about that. 
> 
> This driver is now fairly old and has lagged a bit as we have brought
> in newer cleaner ways of doing things.  Anyhow, I was looking at
> it with a view to moving it out of staging and thought I would clean
> up a few bits whilst doing so.  Note I don't have one of these.
> 
> There are some 'unusual' interfaces in here still such as integrationtime.
> We need to have a think about whether we want to add these to the info
> mask and handle them through read/write_raw or not.
> 
> I'm also decidely unkeen on the manual power enable / disable that is
> still in this driver.  That should ideally be done on demand.
> 
> Hence i am not proposing moving this out of staging just yet!
> 
> Jonathan
> 
> Jonathan Cameron (3):
>   staging:iio:light:tsl2583 use read_raw, write_raw hooks.
>   staging:iio:light:tsl2583 apply in_ prefix to attributes.
>   staging:iio:light:tsl2583 switch to kstrto and strtobool
> 
>  drivers/staging/iio/light/tsl2583.c | 247 +++++++++++++++++-------------------
>  1 file changed, 119 insertions(+), 128 deletions(-)
> 
