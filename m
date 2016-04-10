Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:42919 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbcDJPAS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 11:00:18 -0400
Subject: Re: [PATCH v2 27/30] iio: use parity32 in adxrs450
To: Jonathan Cameron <jic23@kernel.org>, zengzhaoxiu@163.com,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
References: <57031D9D.801@gmail.com>
 <1459937776-8438-1-git-send-email-zengzhaoxiu@163.com>
 <570A6536.3000308@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <570A662E.8030807@metafoo.de>
Date: Sun, 10 Apr 2016 16:41:50 +0200
MIME-Version: 1.0
In-Reply-To: <570A6536.3000308@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2016 04:37 PM, Jonathan Cameron wrote:
> On 06/04/16 11:16, zengzhaoxiu@163.com wrote:
>> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
>>
>> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> Applied to the togreg branch of iio.git as you seem to have addressed
> Lars' comments.

The whole series needs to go through the same tree since the new functions
are introduced in the beginning.

