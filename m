Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:44589 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752628Ab3EGSKP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2013 14:10:15 -0400
Message-ID: <5189441E.6020606@metafoo.de>
Date: Tue, 07 May 2013 20:12:46 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@infradead.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: linux-next: Tree for May 7 (iio)
References: <20130507134922.981483ab1e5cb09e5543a6cc@canb.auug.org.au> <51893523.9000105@infradead.org>
In-Reply-To: <51893523.9000105@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/2013 07:08 PM, Randy Dunlap wrote:
> On 05/06/13 20:49, Stephen Rothwell wrote:
>> Hi all,
>>
>> Please do not add any v3.11 destined work to your linux-next included
>> branches until after v3.10-rc1 is released.
>>
>> I am receiving a (un)reasonable number of conflicts from there being
>> multiple copies of some commits in various trees.   Please clean this up
>> and resist the temptataion to rebase your trees on the way to your
>> upstream ...
>>
>> Changes since 20130506:
>>
> 
> on x86_64:
> 
> when CONFIG_AD5446=y and CONFIG_I2C=m:
> 
> drivers/built-in.o: In function `ad5622_write':
> ad5446.c:(.text+0xae0b5): undefined reference to `i2c_master_send'
> drivers/built-in.o: In function `ad5446_init':
> ad5446.c:(.init.text+0x4f28): undefined reference to `i2c_register_driver'
> drivers/built-in.o: In function `ad5446_i2c_unregister_driver':
> ad5446.c:(.exit.text+0xc73): undefined reference to `i2c_del_driver'
> 

My fault, will fix it. Thanks for reporting.

- Lars
