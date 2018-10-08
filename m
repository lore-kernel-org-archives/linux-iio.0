Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34188 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIFSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Oct 2018 01:18:41 -0400
MIME-Version: 1.0
References: <20181008220227.vbn4wzi34n577yyg@renatolg>
In-Reply-To: <20181008220227.vbn4wzi34n577yyg@renatolg>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Oct 2018 19:04:45 -0300
Message-ID: <CAOMZO5A7zW9FPOmqNBVquj2ysR6V3kok3RXsbUuCfg1WjvAjeg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: adt7316: fix parenthesis alignment
To: renatogeh@gmail.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Renato,

On Mon, Oct 8, 2018 at 7:02 PM Renato Lui Geh <renatogeh@gmail.com> wrote:
>
> This patch fixes most "Alignment should match open parenthesis" check
> warnings found by checkpatch.pl in the addac/adt7316 driver.
> ---

You missed your Signed-off-by tag, which is also reported by checkpatch.pl :-)
