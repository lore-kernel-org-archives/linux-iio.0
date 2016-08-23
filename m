Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36171 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbcHWSKz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2016 14:10:55 -0400
Subject: Re: iio/testing git tree status
To: Alison Schofield <amsfield22@gmail.com>
References: <20160823174350.GA3250@d830.WORKGROUP>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0d607da5-4abc-48c5-63b1-13d9ec8f0b3a@kernel.org>
Date: Tue, 23 Aug 2016 19:03:52 +0100
MIME-Version: 1.0
In-Reply-To: <20160823174350.GA3250@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/16 18:43, Alison Schofield wrote:
> Hi Jonathan,
> 
> I want to submit a patch (new feature) to the iio/testing branch, but a fix
> that is a dependency is only in iio/fixes-togreg.  
> 
> How do these get sync'd? How should I proceed?  I can wait for the sync.
It takes a little while, but as follows:

* I send Greg KH a pull request for fixes-togreg
* He pulls it and sometime later sends Linus a pull request including those fixes.
* Linus pulls it.
* Greg at some point after that does a merge with mainline of the staging-next tree.
* After a pull request for togreg has been pulled, I fast forward my togreg branch
* At that point it will be in the togreg branch which is what testing is a temporary
copy of...

Can take a few weeks.  Might not now happen before the next merge window. Everything
will unroll at that point anyway though so that doesn't really effect timing.

Feel free to post your patch with the dependency listed in the description.
Then poke me when I inevitably forget all about it.

Jonathan
> 
> Thanks,
> alisons
> 

