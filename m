Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51022 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcBXUmk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2016 15:42:40 -0500
Subject: Re: [RFC] i2c_check_functionality and error code
To: Wolfram Sang <wsa@the-dreams.de>
References: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw@mail.gmail.com>
 <56CA1F0D.2060707@kernel.org> <20160221225606.GA1386@katana>
Cc: Matt Ranostay <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux I2C <linux-i2c@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CE15BD.3070800@kernel.org>
Date: Wed, 24 Feb 2016 20:42:37 +0000
MIME-Version: 1.0
In-Reply-To: <20160221225606.GA1386@katana>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/02/16 22:56, Wolfram Sang wrote:
>> Hohum. Wolfram what do you think?
> 
> I'd go for "EOPNOTSUPP" since it is most descriptive. I wouldn't say we
> really need to fix it up in the kernel tree. However, I neither would
> vote against it.
> 
I'm certainly keen on cleaning this up in IIO at the least.
A bit of consistency is always nice and once we have done it once
it should be reasonably pain free.

Anyhow, patches welcome ;)

Jonathan
