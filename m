Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46870 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759086AbdENPYB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 11:24:01 -0400
Subject: Re: [PATCH v2 0/3] coding style warnings fixes
To: Harinath Nampally <harinath922@gmail.com>, lars@metafoo.de
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20170509074617.x6bdqs7innxhrude@mwanda>
 <cover.1494370925.git.harinath922@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <59f9c84c-5336-34c6-dbec-dee28a98997f@kernel.org>
Date: Sun, 14 May 2017 16:23:59 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1494370925.git.harinath922@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/17 00:41, Harinath Nampally wrote:
> This revised patchset is for improvement in [PATCH v2 1/3]
> as per the code review comment from Dan Carpenter.
> 
> Other two patches [PATCH v2 2/3] and [PATCH v2 3/3] are unchanged,
> so they are same as [PATCH 2/3] and [PATCH 3/3] respectively.
> 
> Please find the following related patches:
> [PATCH v2 1/3] staging: iio: meter: Add the comment for mutex definition
> [PATCH v2 2/3] staging: iio: meter: Fix the identations for proper alignments
> [PATCH v2 3/3] staging: iio: meter: Replace symbolic permissions with octal permissions
> 
> Harinath Nampally (3):
>    staging: iio: meter: Add the comment for mutex definition
>    staging: iio: meter: Fix the identations for proper alignments
>    staging: iio: meter: Replace symbolic permissions with octal
>      permissions
> 
>   drivers/staging/iio/meter/ade7753.c | 104 ++++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 52 deletions(-)

Please don't post new versions of a patch series as a reply to earlier versions.
It very rapidly leads to deep and unmanageable threads!

Jonathan
> 

