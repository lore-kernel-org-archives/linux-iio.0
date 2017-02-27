Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48776 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbdB0KC7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 05:02:59 -0500
Subject: Re: [PATCH] staging: iio: ad9834: Moved contents of header file to
 source file
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <1488146361-14383-1-git-send-email-narcisaanamaria12@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b587366e-dec9-c550-3617-2a6d76200423@metafoo.de>
Date: Mon, 27 Feb 2017 10:21:38 +0100
MIME-Version: 1.0
In-Reply-To: <1488146361-14383-1-git-send-email-narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/26/2017 10:59 PM, Narcisa Ana Maria Vasile wrote:
> The contents of the header file are used only by this single source file

Same here, platform data should stay in its the header file, everything else
can and should be moved.


