Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:45780 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdB0JY1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 04:24:27 -0500
Subject: Re: [PATCH] staging: iio: iio-trig-bfin-timer: Move contents of
 header file to source file
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <20170226210516.GA20649@sayli-HP-15-Notebook-PC>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2ba38431-eaf2-ae38-14fe-180a326ae574@metafoo.de>
Date: Mon, 27 Feb 2017 10:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170226210516.GA20649@sayli-HP-15-Notebook-PC>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/26/2017 10:05 PM, sayli karnik wrote:
> The contents of the header file are used only by this single
> source file. Move content into .c and delete .h.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>

Hi,

I apologize, I should have seen this during the first round of review. This
is the platform data struct which is supposed to be supplied to the driver
from outside the driver, so it has to stay in a separate header.

