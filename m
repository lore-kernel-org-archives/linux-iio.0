Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <549930D1.9050600@metafoo.de>
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com>
	<1418721107-5429-2-git-send-email-roberta.dobrescu@gmail.com>
	<CAEnQRZDYT4wUb5uOkqPvkmZ5+Rs8O1TP2Z7mEhF9OeQTHY97gw@mail.gmail.com>
	<549930D1.9050600@metafoo.de>
Date: Tue, 23 Dec 2014 11:24:18 +0200
Message-ID: <CAEnQRZCFvCYsO_1B8D4FkoY_6FRAU8isbmFwwJodCKj7MrbF6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: frequency: Remove 'out of memory' message
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Michael.Hennerich@analog.com,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 23, 2014 at 11:07 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 12/23/2014 09:51 AM, Daniel Baluta wrote:
>>
>> On Tue, Dec 16, 2014 at 11:11 AM, Roberta Dobrescu
>> <roberta.dobrescu@gmail.com> wrote:
>>>
>>> This patch fixes the following checkpatch.pl warning:
>>> WARNING: Possible unnecessary 'out of memory' message
>>>
>>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>>> ---
>>>   drivers/iio/frequency/adf4350.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/frequency/adf4350.c
>>> b/drivers/iio/frequency/adf4350.c
>>> index 63a25d9..2b301eb 100644
>>> --- a/drivers/iio/frequency/adf4350.c
>>> +++ b/drivers/iio/frequency/adf4350.c
>>> @@ -387,10 +387,8 @@ static struct adf4350_platform_data
>>> *adf4350_parse_dt(struct device *dev)
>>>          int ret;
>>>
>>>          pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>> -       if (!pdata) {
>>> -               dev_err(dev, "could not allocate memory for platform
>>> data\n");
>>> +       if (!pdata)
>>>                  return NULL;
>>> -       }
>>>
>> Based on Harmut's review we can return ERR_PTR(-ENOMEM) here
>> and then use IS_ERR and PTR_ERR inside adf4350_probe()
>
>
> This patch is fine as it is. It removes the redundant error message. Every
> thing else should be done in a second patch.

That's better, indeed.

Daniel.
