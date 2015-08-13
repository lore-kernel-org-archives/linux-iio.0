Return-Path: <lars@metafoo.de>
Message-ID: <55CC60B1.6060706@metafoo.de>
Date: Thu, 13 Aug 2015 11:17:37 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Crt Mori <cmo@melexis.com>, Peter Meerwald <pmeerw@pmeerw.net>
CC: Vianney le Clement de Saint-Marcq <vianney.leclement@essensium.com>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mlx90614: Implement filter configuration
References: <1439450079-2703-1-git-send-email-cmo@melexis.com> <alpine.DEB.2.02.1508131044250.30726@pmeerw.net> <CAKv63us8NL7FiBOteGTdGBXG5Lxo3Lw8rSzv=aix-snDsrqpNQ@mail.gmail.com>
In-Reply-To: <CAKv63us8NL7FiBOteGTdGBXG5Lxo3Lw8rSzv=aix-snDsrqpNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 08/13/2015 11:12 AM, Crt Mori wrote:
> On 13 August 2015 at 10:58, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> On Thu, 13 Aug 2015, Crt Mori wrote:
>>
>>> Implemented Low pass 3db frequency filter which configures
>>> FIR and IIR values within the configuration register of EEPROM.
>>> For more standardized interface we have fixed the FIR value
>>> to 1024, while changes in IIR value are directly connected to
>>> filter responses. The new datasheet version will provide a
>>> simplified table (also in reStructured text format below) with
>>> this change, to provide quick overview of possible settings.
>>
>> nitpicking below
>>
>> the patch add .owner = THIS_MODULE, which is unrelated to the rest of the
>> patch
>>
> Ty for noticing - it is already in there, dont know why diff marked it.

It was removed in upstream since it is not necessary.
