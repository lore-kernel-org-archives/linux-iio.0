Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:54120 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933251AbaDJCbC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Apr 2014 22:31:02 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so7241283igq.4
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2014 19:31:01 -0700 (PDT)
Date: Wed, 9 Apr 2014 21:30:59 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 1/3] Removes unwanted space before semicolon
Message-ID: <20140410023058.GA25297@deathray>
References: <1397086129-12112-1-git-send-email-mwelling@ieee.org>
 <1397086129-12112-2-git-send-email-mwelling@ieee.org>
 <20140410014758.GB11347@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140410014758.GB11347@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 09, 2014 at 06:47:58PM -0700, Greg KH wrote:
> On Wed, Apr 09, 2014 at 06:28:47PM -0500, Michael Welling wrote:
> > ---
> >  drivers/staging/iio/light/tsl2583.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> The subject: needs to be better (put Staging: iio:) in the beginning.
> 

Sorry, updated patch series send.

> Also, you forgot a signed-off-by line all of these.
> 
> greg k-h
