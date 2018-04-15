Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:42659 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752464AbeDOTYa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2018 15:24:30 -0400
Message-ID: <e82d25e0d82a55eba1097eab3c679ad5f667e999.camel@perches.com>
Subject: Re: [PATCH v2 14/14] staging: iio: Remove ad7746 from staging
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>,
        =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 15 Apr 2018 12:24:23 -0700
In-Reply-To: <20180415164351.2666a114@archlinux>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
         <1523637411-8531-15-git-send-email-hernan@vanguardiasur.com.ar>
         <20180415164351.2666a114@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2018-04-15 at 16:43 +0100, Jonathan Cameron wrote:
> On Fri, 13 Apr 2018 13:36:51 -0300
> Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> 
> > Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> 
> Please have a single patch (with move detection turned off) for this and the
> previous.

> Allows easy review by showing us the code but doesn't lead to a stage in which
> two different versions will build and hence probably break bisectiblity.

Moving both files in a single patch is fine but
move detection off is much harder to review.

