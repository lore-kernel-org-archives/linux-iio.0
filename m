Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1158 "EHLO
	smtp-out-046.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757537Ab3ECHug (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2013 03:50:36 -0400
Message-ID: <51836C28.4050806@metafoo.de>
Date: Fri, 03 May 2013 09:50:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: alessandro osima <alex.osima@gmail.com>
CC: linux-iio@vger.kernel.org, Hunyue Yau <hy-gsoc@hy-research.com>
Subject: Re: Abstracting and extending evdev to work with the iio subsystem
References: <CAOTW74kb_qJP=by_iKOTCHVurh2wEc6nfmdL-F2ddqq3aQ672g@mail.gmail.com>
In-Reply-To: <CAOTW74kb_qJP=by_iKOTCHVurh2wEc6nfmdL-F2ddqq3aQ672g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/30/2013 04:24 AM, alessandro osima wrote:
> Hello everyone, my name is  Alessandro Osima and I'm a computer
> science student at Università degli Studi di Milano, Italy (second
> year, equivalent to bachelor).
> 
> 
>  For this year's Google Summer of Code I have decided to submit an
> application proposal focused on abstracting evdev  from input to allow
> iio and other subsystems to take advantage of it to send/receive
> events and data to userspace application troughout files located in
> the /dev directory.
> 
> This http://www.google-melange.com/gsoc/proposal/review/google/gsoc2013/asion/1#
>  is my proposal.
> 
> I would kindly ask your opinions about this project and would be very
> grateful for any comments and suggestion to improve it.
> 

Hi,

Sounds interesting. Did you hd a look at the existing IIO event interface
(drivers/iio/industrialio-event.c)? I'm asking because you don't seem to
mention it in your proposal.

- Lars
