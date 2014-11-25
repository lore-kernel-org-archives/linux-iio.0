Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1095 "EHLO
	smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaKYQgq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Nov 2014 11:36:46 -0500
Message-ID: <5474B01D.8020701@metafoo.de>
Date: Tue, 25 Nov 2014 17:36:45 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] Add valid sample channel
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/2014 01:48 PM, Vlad Dogaru wrote:
> This is an attempt to address the problem of buffering in devices which have
> different scan frequencies for different channels.

Will these frequencies still be related or completely arbitrary?
